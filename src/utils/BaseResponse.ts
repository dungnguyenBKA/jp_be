import {Response} from "express";
import {QueryFailedError} from "typeorm";

interface BaseResponse<T> {
  status_code: number,
  data?: T,
  message: string,
}

function makeSuccess<T>(res: Response, data: T, message = "Success") {
  res.status(200).send({
    status_code: 200,
    data,
    message: message
  })
}

function makeError(res: Response, errorCode = 400, message = "Error occurred") {
  res.status(errorCode).send({
    status_code: errorCode,
    message: message
  })
}

export const isQueryFailedError = (err: unknown): err is QueryFailedError =>
  err instanceof QueryFailedError;

function makeErrorInCatch(res: Response, e: unknown) {
  console.error(e)

  if (isQueryFailedError(e)) {
    console.error(e)
    res.status(400).send({
      status_code: 400,
      message: e?.message
    })
    return
  }

  res.status(400).send({
    status_code: 400,
    message: JSON.stringify(e,null, 2)
  })
}

export {
  makeSuccess,
  makeError,
  makeErrorInCatch
}
