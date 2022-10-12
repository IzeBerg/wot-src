package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BadgeInfoBlockVO extends DAAPIDataClass
   {
       
      
      public var badgeImgSource:String = "";
      
      public var vehImgSource:String = "";
      
      public var playerName:String = "";
      
      public var vehName:String = "";
      
      public var stripImgSource:String = "";
      
      public function BadgeInfoBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
