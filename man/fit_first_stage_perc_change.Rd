% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit_first_stage_elasticity.R
\name{fit_first_stage_perc_change}
\alias{fit_first_stage_perc_change}
\title{Estimate Percentage Change}
\usage{
fit_first_stage_perc_change(
  DT,
  y,
  months = "1_12",
  x_main = "first_mo",
  x_int = NULL,
  keep_vars,
  cont_risk_var = NULL,
  n_quant = 5,
  B = 10,
  quiet = FALSE
)
}
\arguments{
\item{DT}{a data.table}

\item{y}{character vector, name of response variable(s) without months suffix}

\item{months}{character vector (default = "1_12"), months of y variable to
estimate. Should be in the form "YEAR_MONTH" where year is between 1 and 2
and month is between 1 and 12.}

\item{x_main}{character (default = "first_mo"), name of instrument}

\item{x_int}{character vector, names of variables to interact instrument with}

\item{keep_vars}{character vector, column names for the binary keep variables}

\item{cont_risk_var}{character (default = NULL), name of the continuous
predicted risk variable}

\item{n_quant}{integer (default = 5), number of quntiles to break predicted
risk in to. High risk is defined as being in the top quantile.}

\item{B}{integer, number of bootstrap samples to use when calculating
standard errors}

\item{quiet}{logical (default = FALSE), if TRUE then does not print progress}
}
\value{
List with 2 elements:
\item{dt_est}{a data.table of the first stage estimates (and their standard 
              errors) in percentage terms by the specified interactions}
\item{dtp}{a data.table with the conditional means of y by enrollment month, 
           spending bin, any any other x_int}
}
\description{
Estimate the first stage (y ~ first_mo), where y is a binary variable (e.g.
 statin fill indiator) in terms of percentage change and bootstap the
 standard errors
}
