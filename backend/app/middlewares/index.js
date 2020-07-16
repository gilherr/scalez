const getUserMetaFromCookie = (req, res, next) => {
  const userMetaCookie = req.cookies.userMeta;

  if(req.path !== '/users' && !userMetaCookie){
    res.status(401).json({error: 'cant make requests without user meta cookie'});
    res.end()
  } else {
    req.userMetaCookie = JSON.parse(userMetaCookie);

    if(!req.userMetaCookie.userId){
      res.status(401).json({error: 'missing user info'});
      res.end()
    }

    next();
  }
}

module.exports = {
  getUserMetaFromCookie
}