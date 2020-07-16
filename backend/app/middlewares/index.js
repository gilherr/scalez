const getUserMetaFromCookie = (req, res, next) => {
  const userMeta = req.cookies.userMeta;

  if(!userMeta){
    next();
  } else {
    const {user_id, isNew} = JSON.parse(userMeta);
    req.userId = user_id;
    req.isNewUser = isNew;
    next();
  }
}

module.exports = {
  getUserMetaFromCookie
}