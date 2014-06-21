SELECT
  this_.ID AS y0_
FROM hxtd.SM_FUNCTION this_ INNER JOIN hxtd.SM_MENU menu3_ ON this_.MENU_ID = menu3_.ID
  INNER JOIN hxtd.SM_ROLE_FUNC roles6_ ON this_.ID = roles6_.FUNC_ID
  INNER JOIN hxtd.SM_ROLE role1_ ON roles6_.ROLE_ID = role1_.ID
  INNER JOIN hxtd.SM_USER_ROLE owners8_ ON role1_.ID = owners8_.ROLE_ID
  INNER JOIN hxtd.SM_USER owner2_ ON owners8_.USER_ID = owner2_.ID
WHERE owner2_.ID = 4