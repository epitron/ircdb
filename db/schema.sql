CREATE TABLE quasseluser (
       userid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       username TEXT UNIQUE NOT NULL,
       password TEXT NOT NULL
);
CREATE TABLE sender ( -- THE SENDER OF IRC MESSAGES
       senderid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       sender TEXT UNIQUE NOT NULL
);
CREATE TABLE network (
       networkid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       userid INTEGER NOT NULL,
       networkname TEXT NOT NULL,
       identityid INTEGER NOT NULL DEFAULT 1,
       encodingcodec TEXT NOT NULL DEFAULT "ISO-8859-15",
       decodingcodec TEXT NOT NULL DEFAULT "ISO-8859-15",
       servercodec TEXT NOT NULL DEFAULT "",
       userandomserver INTEGER NOT NULL DEFAULT 0, -- BOOL
       perform TEXT,
       useautoidentify INTEGER NOT NULL DEFAULT 0, -- BOOL
       autoidentifyservice TEXT,
       autoidentifypassword TEXT,
       usesasl INTEGER NOT NULL DEFAULT 0, -- BOOL
       saslaccount TEXT,
       saslpassword TEXT,
       useautoreconnect INTEGER NOT NULL DEFAULT 0, -- BOOL
       autoreconnectinterval INTEGER NOT NULL DEFAULT 0,
       autoreconnectretries INTEGER NOT NULL DEFAULT 0,
       unlimitedconnectretries INTEGER NOT NULL DEFAULT 0, -- BOOL
       rejoinchannels INTEGER NOT NULL DEFAULT 0, -- BOOL
       connected INTEGER NOT NULL DEFAULT 0, -- BOOL
       usermode TEXT, -- user mode to restore
       awaymessage TEXT, -- away message to restore (empty if not away)
       attachperform TEXT, -- perform list for on attach
       detachperform TEXT, -- perform list for on detach
       UNIQUE (userid, networkname)
);
CREATE TABLE buffer (
  bufferid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  userid INTEGER NOT NULL,
  groupid INTEGER,
  networkid INTEGER NOT NULL,
  buffername TEXT NOT NULL,
  buffercname TEXT NOT NULL, -- CANONICAL BUFFER NAME (lowercase version)
  buffertype INTEGER NOT NULL DEFAULT 0,
  lastseenmsgid INTEGER NOT NULL DEFAULT 0,
  markerlinemsgid INTEGER NOT NULL DEFAULT 0,
  key TEXT,
  joined INTEGER NOT NULL DEFAULT 0 -- BOOL
);
CREATE UNIQUE INDEX buffer_idx 
       ON buffer(userid, networkid, buffername);
CREATE UNIQUE INDEX buffer_cname_idx 
       ON buffer(userid, networkid, buffercname);
CREATE TABLE backlog (
  messageid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  time INTEGER NOT NULL,
  bufferid INTEGER NOT NULL,
  type INTEGER NOT NULL,
  flags INTEGER NOT NULL,
  senderid INTEGER NOT NULL,
  message TEXT);
CREATE TABLE coreinfo (
       key TEXT NOT NULL PRIMARY KEY,
       value TEXT);
CREATE TABLE ircserver (
    serverid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    userid INTEGER NOT NULL,
    networkid INTEGER NOT NULL,
    hostname TEXT NOT NULL,
    port INTEGER NOT NULL DEFAULT 6667,
    password TEXT,
    ssl INTEGER NOT NULL DEFAULT 0, -- bool
    sslversion INTEGER NOT NULL DEFAULT 0,
    useproxy INTEGER NOT NULL DEFAULT 0, -- bool
    proxytype INTEGER NOT NULL DEFAULT 0,
    proxyhost TEXT NOT NULL DEFAULT 'localhost',
    proxyport INTEGER NOT NULL DEFAULT 8080,
    proxyuser TEXT,
    proxypass TEXT
);
CREATE INDEX backlog_bufferid_idx ON backlog(bufferid);
CREATE INDEX backlog_buffer_time_idx ON backlog (bufferid, time);
CREATE INDEX buffer_user_idx ON buffer(userid);
CREATE TABLE user_setting (
    userid INTEGER NOT NULL,
    settingname TEXT NOT NULL,
    settingvalue BLOB,
    PRIMARY KEY (userid, settingname)
);
CREATE TABLE identity (
       identityid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       userid INTEGER NOT NULL,
       identityname TEXT NOT NULL,
       realname TEXT NOT NULL,
       awaynick TEXT,
       awaynickenabled INTEGER NOT NULL DEFAULT 0, -- BOOL
       awayreason TEXT,
       awayreasonenabled INTEGER NOT NULL DEFAULT 0, -- BOOL
       autoawayenabled INTEGER NOT NULL DEFAULT 0, -- BOOL
       autoawaytime INTEGER NOT NULL,
       autoawayreason TEXT,
       autoawayreasonenabled INTEGER NOT NULL DEFAULT 0, -- BOOL
       detachawayenabled INTEGER NOT NULL DEFAULT 0, -- BOOL
       detachawayreason TEXT,
       detachawayreasonenabled INTEGER NOT NULL DEFAULT 0, -- BOOL       
       ident TEXT,
       kickreason TEXT,
       partreason TEXT,
       quitreason TEXT,
       sslcert BLOB,
       sslkey BLOB,
       UNIQUE (userid, identityname)
);
CREATE TABLE identity_nick (
       nickid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       identityid INTEGER NOT NULL,
       nick TEXT NOT NULL,
       UNIQUE (identityid, nick)
);
