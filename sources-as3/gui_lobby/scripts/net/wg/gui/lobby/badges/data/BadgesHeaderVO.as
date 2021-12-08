package net.wg.gui.lobby.badges.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BadgesHeaderVO extends DAAPIDataClass
   {
       
      
      public var backBtnLabel:String = "";
      
      public var backBtnDescrLabel:String = "";
      
      public var descrTf:String = "";
      
      public var playerText:String = "";
      
      public function BadgesHeaderVO(param1:Object)
      {
         super(param1);
      }
   }
}
