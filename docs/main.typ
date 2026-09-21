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

Blockchain là công nghệ cho phép giám sát các chuỗi khối với nhau để đảm bảo tính hợp lệ của các giao dịch. Mọi giao dịch trong blockchain là bất biến và ta có thể có thể cập nhật dữ liệu dựa trên việc bổ sung trạng thái mới của dữ liệu gốc. #cite(<nakamoto2008bitcoin>)

Trong phạm vi dự án, blockchain sẽ được ứng dụng làm sổ cái bất biến để lưu trữ dữ liệu.

== Giao thức UMA

Giao thức UMA là một giao thức nằm trên layer 2 của Ethereum. #cite(<uma_optimistic_oracle>) Giao thức này hoạt động dựa trên việc một giao dịch được xem là hợp lệ ngay vừa khi được đưa vào chain với điều kiện phải có một khoản đặt cọc từ trước. #cite(<cryptocom_blockchain_bonds_2025>) Một bên có thể thách thức tính hợp lệ của giao dịch với điều kiện phải đặt cọc một khoản tương đương. Sau khi tranh chấp được mở ra thì các bên theo dõi sẽ đồng loạt vote với một lượng điểm đã được đặt cọc, nếu lựa chọn nằm ở phe đa số khi có kết quả cuối cùng thì sẽ được nhận thưởng, còn không thì sẽ mất toàn bộ khoản đặt cọc. #cite(<optimism_fault_dispute_game>)

Điều này áp dụng cho cả bên đưa ra giao dịch và thách thức giao dịch. Từ đó ta có thể tăng thông lượng thay vì phải kiểm duyệt ngay từ đầu vào, dù điều này cũng đi kèm với rủi ro là một số dữ liệu không hợp lệ có thể bị đưa vào và cho kết quả sai.

== Federated Learning

Học kết hợp được ứng dụng trong bối cảnh tận dụng việc huấn luyện các thiết bị biên để huấn luyện model thay vì thực hiện tại các trung tâm dữ liệu lớn. Điều này giúp tiết kiệm chi phí và có thể cải thiện model một cách linh hoạt hơn.

Trong phạm vi dự án, mỗi thiết bị sẽ tự động huấn luyện model tại thiết bị biên. Sau đó nó sẽ cập nhật thông tin lên server để huấn luyện thành một model hoàn chỉnh, model hoàn chỉnh đó sẽ cập nhật lại tham số cho các thiết bị biên, từ đó cải thiện hiệu suất rõ rệt.

== Lý thuyết trò chơi

Để chứng minh tính khả thi của dự án về mặt logic, ta ứng dụng các công thức và một số khái niệm của lý thuyết trò chơi để chứng minh khả năng chịu lỗi của mô hình trong các điều kiện thực thi.

== Schelling point

Schelling point là một khái niệm dùng để chỉ một tập các quyết định giữa các đối tượng mà không cần phải giao tiếp với nhau. Chẳng hạn một lỗ hổng bảo mật khi được phát hiện thì các tác tử khác sẽ có hai lựa chọn là chấp nhận hoặc từ chối tính hợp lệ của lỗ hổng đó với một khoản đặt cọc.

Thông qua việc kiểm tra cục bộ và chạy thử, các tác tử sẽ đưa ra nhận xét và đưa ra kết quả.

Điểm khiến schelling point khác biệt chính là cơ chế thưởng, phạt dựa trên việc bỏ phiếu theo đa số khi có kết quả cuối cùng. Do đó các tác tử không chỉ đánh giá lỗ hổng bảo mật mà còn phải đánh giá xem các tác tử khác liệu có đưa ra chung nhận xét của bản thân hay không.

== Trò chơi Poisson

Trò chơi possion xuất hiện để giới thiệu về một trò chơi mà trong đó số lượng người tham gia là không xác định.

Đây là một khung lý thuyết rất quan trọng bởi vì cơ chế schelling point được đề cập ở trước đó sẽ thưởng, phạt dựa trên việc có bỏ phiếu theo kết quả đa số hay không. Việc không biết trước số lượng khiến cho việc tấn công poison data trở nên khó dự đoán hơn và khi ta tăng số lượng các tác tử lên thì độ chính xác của lỗ hổng có thể được cải thiện.

= Mô tả

Mỗi thiết bị sẽ chạy phần mềm để quét thư mục và kiểm tra lỗi. Chúng sẽ tự kiểm tra trạng thái lỗi của các phần mềm tại thiết bị biên trước khi gửi lên server thông qua một thư mục chứa source code đã chuẩn bị từ trước.

Server sẽ là nơi giám sát trạng thái của các lỗ hổng được thông báo từ thiết bị đó. Ta ứng dụng giao thức UMA để cho các tác tử kiểm tra tính chính xác của dữ liệu được gửi lên và kiểm duyệt chúng.


#figure(
  image("../assets/overview.png", width: 100%),
  caption: [],
) <fig-overview>

= Yêu cầu

== Chuẩn hóa dữ liệu

uuCó hai dữ liệu sẽ được đưa vào. Thứ nhất là dữ liệu dùng để training (cho flower trước) và source code.

Sẽ có timestamp về thời hạn của dispute để gửi lựa chọn lên.

Các dữ liệu về trạng thái của lỗ hổng sẽ được nối tiếp dưới dạng chuỗi, không ghi đè lên nhau. (Dùng mongoDB)

== Thiết bị biên

- Có thể pull model có sẵn hoặc tự tạo model riêng.

- Sẽ trả về kết quả trước khi gửi lên máy chủ trung tâm. Có ghi rõ thời gian giới hạn.

== Máy chủ trung tâm

- Sẽ lưu lại thông tin về các thiết bị tham gia

- Tạo web hook để các thiết bị khác cùng cập nhật.

= Quy tắc

#bibliography(
  title: [Tài liệu tham khảo],
  "references.bib",
  style: "ieee",
)
