/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: MIT
 */

delegate void Rn.WorkerFunc ();
delegate G Rn.ThreadFunc<G> () throws Error;

[Compact (opaque = true)]
class Rn.Worker {
  WorkerFunc func;

  public Worker (owned WorkerFunc func) {
    this.func = (owned) func;
  }

  public void run () {
    func ();
  }
}

namespace Rn.ThreadUtils {
  Once<ThreadPool<Worker>> _once;

  unowned ThreadPool<Worker> _get_thread_pool () {
    return _once.once (() => {
      return new ThreadPool<Worker>.with_owned_data (
          worker => worker.run (), (int) get_num_processors (), false);
    });
  }

  async G run_in_thread<G> (owned ThreadFunc<G> func) throws Error {
    unowned var thread_pool = _get_thread_pool ();

    G result = null;
    Error? error = null;

    thread_pool.add (new Worker (() => {
      try {
        result = func ();
      } catch (Error err) {
        error = err;
      }

      Idle.add (run_in_thread.callback);
    }));

    yield;

    if (error != null)
      throw error;

    return result;
  }
}
