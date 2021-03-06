% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/evaluate_ensemble.R
\name{evaluate_ensemble}
\alias{evaluate_ensemble}
\title{Evaluate ML Ensemble Model Predictions}
\usage{
evaluate_ensemble(dt_scores, id_vars, set_var, pred_vars)
}
\arguments{
\item{dt_scores}{data.table with all variables in other parameters}

\item{id_vars}{character vector, names of id variables}

\item{set_var}{character, name of variable with sett identifiers}

\item{pred_vars}{character vector, names of prediction variables}
}
\value{
data.table with mse/rsq by model and set
}
\description{
Evaluate ML Ensemble Model Predictions
}
