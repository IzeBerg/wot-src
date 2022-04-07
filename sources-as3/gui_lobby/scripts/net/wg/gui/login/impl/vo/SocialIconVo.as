package net.wg.gui.login.impl.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SocialIconVo extends DAAPIDataClass
   {
       
      
      public var socialId:String = "";
      
      public var tpHeader:String = "";
      
      public var tpBody:String = "";
      
      public function SocialIconVo(param1:Object)
      {
         super(param1);
      }
   }
}
