#' Subset to analystic sample
#' 
#' @param DT a data.table
#' @param subset_vars variables to subset
#' @param progress logical, if TRUE prints where in subsetting process the
#'  function is
#' @param balance_vars string character, if non-NULL, then estimates balance
#' @param inst chatacter, name of instrument to check balance on
#' 
#' @return a list with three elements
#' \item{DT_subset}{Subsetted data.table}
#' \item{obs}{data.table with observations at each subsetting step}
#' \item{dt_bal}{data.table with first stage on balance variables at each 
#'               subset}
#' 
#' @importFrom stats lm
#' @importFrom data.table copy uniqueN data.table
#' 
#' @export
subset_sample <- function(DT, subset_vars, progress = F, balance_vars = NULL, 
                          inst = "first_mo") {
  DT_subset <- DT
  obs <- data.frame(subset = "all", obs = nrow(DT_subset),
                    u_obs = uniqueN(DT_subset$bene_id))
  dt_fit <- data.table()
  for (var in subset_vars) {
    if (progress == T) {
      print(var)
    }
    DT_subset  <- DT_subset[get(var) == 1, ]
    obs1 <- data.table(subset = var, obs = nrow(DT_subset),
                       u_obs = uniqueN(DT_subset$bene_id))
    obs <- rbind(obs, obs1)
    if (!is.null(balance_vars)) {
      dt_fit1 <- iter_balance_fit(DT_subset, balance_vars, inst = inst) %>% 
        .[, subset_var := var]
      dt_fit %<>% rbind(dt_fit1)
    }
  }
  print(obs)
  return_list <- list(DT_subset = DT_subset, obs = obs, dt_bal = dt_fit)
  return(return_list)
}

iter_balance_fit <- function(DT, balance_vars, inst = "first_mo") {
  dt_fit <- data.table()
  for (b in balance_vars) {
    DT_fit <- copy(DT) %>% 
      .[, y := get(b)] %>% 
      .[, inst_var := get(inst)]
    fit <- lm(y ~ inst_var, data = DT_fit)
    dt_fit1 <- fit_to_dt(fit, "inst_var") %>% 
      .[, variable := b]
    dt_fit %<>% rbind(dt_fit1)
  }
  return(dt_fit)
}

if(getRversion() >= "2.15.1") {
  utils::globalVariables(c("y", "inst_var", "variable", "subset_var"))
} 