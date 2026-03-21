## Storage Systems

For this system, different storage systems are used based on the type of data and purpose. A relational database (SQL) is used to store structured data such as patient records, hospital reports, and administrative details. This is important because structured data needs consistency and fast querying.

A data lake is used to store raw data such as historical treatment data, logs, and ICU device data. This allows the system to keep large amounts of data in its original form, which can later be used for analysis and machine learning.

A vector database is used to support natural language queries from doctors. It stores embeddings of medical records so that the system can understand the meaning of queries like “Has this patient had a cardiac event before?” even if the wording is different.

For real-time ICU data, a streaming system is used to handle continuous data flow and store it efficiently before processing.

## OLTP vs OLAP Boundary

The OLTP (Online Transaction Processing) system handles day-to-day operations such as storing patient records, updating hospital data, and recording ICU readings. This happens in the relational database (SQL) where data is frequently inserted and updated.

The OLAP (Online Analytical Processing) system begins after the data is collected and stored in the data lake. In this layer, data is cleaned, processed, and analyzed using ETL pipelines and machine learning models.

The boundary between OLTP and OLAP is the point where data moves from the transactional database to the data lake for analysis. After this point, the focus shifts from storing data to analyzing it for insights such as readmission risk and report generation and doctor's query.

## Trade-offs

One major trade-off in this design is between real-time processing and system complexity. Supporting real-time ICU data using streaming systems makes the architecture more complex and harder to manage.

However, real-time data is important for monitoring patients and generating timely alerts. To manage this trade-off, the system can process only critical data in real time, while less important data can be processed in batches.

This approach reduces system load while still ensuring that important patient data is handled quickly.
