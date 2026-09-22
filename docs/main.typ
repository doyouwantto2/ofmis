#import "template.typ": template
#show: template

#align(center)[
  #text(size: 2em)[*Bản thiết kế*]
]

= Giới thiệu

Chủ đề của dự án sẽ liên quan đến hệ thống đa tác tử, máy học, bảo mật thông tin và blockchain, mục tiêu cuối cùng là xây dựng một model hoàn chỉnh thông qua học kết hợp để từ đó có thể cải thiện khả năng xác định lỗi ở các phần mềm, giải quyết vấn đề về việc tác tử đôi khi sẽ đưa ra kết luận sai.

Đây là một dự án được tạo ra với mục đích làm nghiên cứu khoa học, kiêm luôn đồ án môn học IE105 và IE221. Trong đó có sự tham gia của các thành viên bao gồm:

- Đinh Thanh Phong

- Nguyễn Nam Phong

- Đặng Lê Thanh Minh

- Bùi Đỗ Đức Phúc

= Mục tiêu

Nghiên cứu này đặt ra câu hỏi đó là nếu một tác tử đi tìm lỗ hổng bên trong phần mềm thì làm sao ta chứng minh lỗ hổng đó đáng tin cậy mà không cần phải thông qua sự kiểm duyệt của con người? Và nếu như mỗi tác tử phụ trách 1 thiết bị thì làm sao ta ứng dụng Federated Learning để có thể cải thiện model trên thiết bị đó?

= Tiền đề

== Blockchain

Blockchain là một công nghệ sổ cái phân tán, trong đó các giao dịch và dữ liệu được ghi nhận thành các khối và liên kết với nhau theo một chuỗi. Tính toàn vẹn của dữ liệu được duy trì thông qua cơ chế đồng thuận và các cơ chế mật mã. Dữ liệu đã được ghi nhận trên blockchain thường khó bị thay đổi mà không làm thay đổi trạng thái của chuỗi. #cite(<nakamoto2008bitcoin>)

Trong phạm vi dự án, blockchain sẽ được ứng dụng làm sổ cái bất biến để lưu trữ dữ liệu.

== Giao thức UMA

Giao thức UMA là một giao thức giải quyết tranh chấp được xây dựng trên Ethereum và có thể được sử dụng bởi các ứng dụng trên blockchain. #cite(<uma_optimistic_oracle>) Giao thức này hoạt động dựa trên cơ chế optimistic assertion: một bên có thể đưa ra một lời khẳng định về một dữ liệu hoặc sự kiện cùng với một khoản đặt cọc. Lời khẳng định sẽ được xem là hợp lệ nếu không có bên nào thách thức trong khoảng thời gian cho phép. #cite(<uma_optimistic_oracle>) Một bên khác có thể thách thức lời khẳng định bằng cách đưa ra một khoản đặt cọc. Nếu có tranh chấp, kết quả sẽ được đưa tới cơ chế giải quyết tranh chấp của UMA để xác định kết quả cuối cùng. #cite(<uma_optimistic_oracle>)

Điều này cho phép dữ liệu được xử lý theo cơ chế optimistic thay vì phải kiểm tra ngay từ đầu vào, dù điều này cũng đi kèm với rủi ro là một số dữ liệu không hợp lệ có thể được đưa vào trong khoảng thời gian trước khi tranh chấp được giải quyết.

== Federated Learning

Học kết hợp được ứng dụng trong bối cảnh tận dụng việc huấn luyện các thiết bị biên để huấn luyện model thay vì thực hiện tại các trung tâm dữ liệu lớn. Điều này giúp tiết kiệm chi phí và có thể cải thiện model một cách linh hoạt hơn.

Trong phạm vi dự án, mỗi thiết bị sẽ tự động huấn luyện model tại thiết bị biên. Sau đó nó sẽ cập nhật tham số hoặc model update lên server để thực hiện quá trình tổng hợp thành một model tổng thể, nó sẽ cập nhật lại tham số cho các thiết bị biên, từ đó cải thiện hiệu suất rõ rệt.

== Lý thuyết trò chơi

Để chứng minh tính khả thi của dự án về mặt logic, ta ứng dụng các công thức và một số khái niệm của lý thuyết trò chơi để chứng minh khả năng chịu lỗi của mô hình trong các điều kiện thực thi.

== Schelling point

Schelling point là một khái niệm dùng để chỉ một lựa chọn hoặc kết quả mà các đối tượng có xu hướng cùng hướng tới mà không cần phải giao tiếp trực tiếp với nhau. #cite(<naval_schelling_point_2019>) Chẳng hạn một lỗ hổng bảo mật khi được phát hiện thì các tác tử khác sẽ có hai lựa chọn là chấp nhận hoặc từ chối tính hợp lệ của lỗ hổng đó với một khoản đặt cọc.

Thông qua việc kiểm tra cục bộ và chạy thử, các tác tử sẽ đưa ra nhận xét và đưa ra kết quả.

Trong phạm vi dự án, cơ chế thưởng, phạt có thể được sử dụng để khuyến khích các tác tử lựa chọn kết quả mà họ dự đoán là kết quả chung của các tác tử khác. Do đó các tác tử không chỉ đánh giá lỗ hổng bảo mật mà còn phải đánh giá xem các tác tử khác liệu có đưa ra chung nhận xét của bản thân hay không.

== Trò chơi Poisson

Trò chơi Poisson xuất hiện để giới thiệu về một trò chơi mà trong đó số lượng và loại người tham gia có tính không chắc chắn, thường được mô hình hóa bằng phân phối Poisson. #cite(<myerson1998population>)

Đây là một khung lý thuyết rất quan trọng bởi vì cơ chế Schelling point được đề cập ở trước đó có thể được phân tích trong trường hợp số lượng tác tử tham gia không được biết trước. Việc không biết trước số lượng tác tử có thể được nghiên cứu để đánh giá ảnh hưởng của quy mô mạng lưới đến hành vi của các tác tử và khả năng chống lại các tác nhân đưa dữ liệu sai lệch.

= Mô tả

Mỗi thiết bị sẽ chạy phần mềm để quét thư mục và kiểm tra lỗi. Chúng sẽ tự kiểm tra trạng thái lỗi của các phần mềm tại thiết bị biên trước khi gửi lên server thông qua một thư mục chứa source code đã chuẩn bị từ trước.

Server sẽ là nơi giám sát trạng thái của các lỗ hổng được thông báo từ thiết bị đó. Ta ứng dụng giao thức UMA để cho các assertion về lỗ hổng được kiểm tra và giải quyết tranh chấp khi có tác tử thách thức.

#figure(
  image("assets/overview.png", width: 80%),
  caption: [Cấu trúc tổng thể],
) <fig-overview>

= Yêu cầu

Ta chia làm hai project nhỏ:

- Thứ nhất là tác tử đi tìm lỗ hổng bên trong source code trên thiết bị.

- Thứ hai là máy chủ trung tâm để xử lý dữ liệu về lỗ hổng mà các tác tử báo cáo.

#figure(
  image("assets/flow.drawio.png", width: 80%),
  caption: [Sơ đồ tổng thể về logic hoạt động],
) <fig-flow.drawio>

= Công nghệ sử dụng

- Ollama: Kéo các model về để sử dụng

- Langchain: Cho các tác tử đọc dữ liệu và xử lý thông tin

- Langgraph: Xây dựng các quy tắc để các tác tử phải tuân theo

- MongoDB: Chứa dữ liệu huấn luyện và dữ liệu đầu ra

= Chuẩn bị dữ liệu

Ta sẽ train cho flower trước thông qua các dataset. #cite(<chen2023diversevul>)

== Chuẩn hóa dữ liệu

Các thông tin về claim lẫn dispute thì ta phải định nghĩa trước schema cho collection.

Để theo dõi thứ tự và thời điểm thay đổi trạng thái thì ta sẽ có timestamp ở trong tất cả các collection.

Các dữ liệu về trạng thái của lỗ hổng sẽ được nối tiếp dưới dạng chuỗi, không ghi đè lên nhau. (Dùng MongoDB để lưu trữ dữ liệu trước khi đưa vào chain)

== Thiết bị biên

- Cho phép pull model có sẵn hoặc sử dụng model riêng.

- Sẽ xử lý trước khi gửi lên máy chủ trung tâm. Có ghi rõ thời gian cụ thể.


#figure(
  image("assets/device.png", width: 80%),
  caption: [Mô tả hành động ở thiết bị biên],
) <fig-device>

== Máy chủ trung tâm

- Sẽ lưu lại thông tin về các thiết bị tham gia.

- Tạo web hook để các thiết bị khác cùng cập nhật khi có thay đổi.

#figure(
  image("assets/center.png", width: 80%),
  caption: [],
) <fig-center>

= Quy tắc

#bibliography(
  title: [Tài liệu tham khảo],
  "references.bib",
  style: "ieee",
)
