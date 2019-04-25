## 네이버 증권 크롤링 

# 라이브러리 불러오기
library(tidyverse)
library(httr)
library(rvest)


# url 복사 
'https://finance.naver.com/sise/sise_index.nhn?code=KOSPI'

# HTTP 요청 실행
res <- GET(url = 'https://finance.naver.com/sise/sise_index.nhn?code=KOSPI')

# 응답 결과 확인 
print(x = res)

# 페이지 상단 테이블 추출 (locale 임시 변경 for Win 사용자)
Sys.setlocale(category = 'LC_ALL', locale = 'C')
searchTable <- res %>%
  read_html(encoding = "euc-kr") %>% 
  html_nodes(css = '#contentarea_left > div.box_top_sub > div > div.subtop_sise_detail > table') %>%
  html_table(fill = TRUE)

Sys.setlocale(category = 'LC_ALL', locale = 'korean')


# 추출 여부 확인
print(searchTable)
data <- searchTable[[1]]
glimpse(data)

# 보기 좋게 전처리
colnames <- rep(c('Category', 'Value'),2)
newTable <- cbind(data[-4,1:2],data[-4,3:4])
other <- data[4,] %>% str_split(pattern = '\n\t')
content <- other[[4]] %>% str_trim() %>% str_sub(start = 1, end = 5)
content
value <- other[[4]] %>% str_trim() %>%str_sub(start = 6)
for(i in 1:length(other[[4]])) {newTable[3+i,1] <- content[i]}
for(i in 1:length(other[[4]])) {newTable[3+i,2] <- value[i]}
colnames(newTable) <- colnames
print(newTable)
## End of Document


