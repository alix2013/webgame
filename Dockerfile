FROM ubuntu:24.04

# Disable interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv curl  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN useradd -m -d /home/web web

COPY start.sh /start.sh
RUN chmod a+x /start.sh

RUN chmod 700 /home/web
# Set working directory
WORKDIR /home/web

COPY --chown=web:web . .

# Install Python dependencies
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir -r requirements.txt

USER web

# Expose the Flask default port

EXPOSE 8000 

ENTRYPOINT ["/start.sh"]
CMD []

