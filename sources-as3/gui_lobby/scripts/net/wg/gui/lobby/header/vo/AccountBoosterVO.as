package net.wg.gui.lobby.header.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AccountBoosterVO extends DAAPIDataClass
   {
       
      
      public var hasActiveBooster:Boolean = false;
      
      public var hasAvailableBoosters:Boolean = false;
      
      public var boosterIcon:String = "";
      
      public var boosterText:String = "";
      
      public var boosterBg:String = "";
      
      public function AccountBoosterVO(param1:Object)
      {
         super(param1);
      }
   }
}
