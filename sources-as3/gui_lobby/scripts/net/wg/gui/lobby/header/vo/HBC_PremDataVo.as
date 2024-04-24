package net.wg.gui.lobby.header.vo
{
   public class HBC_PremDataVo extends HBC_AbstractVO
   {
       
      
      public var btnLabel:String = "";
      
      public var btnLabelShort:String = "";
      
      public var doLabel:String = "";
      
      public var timeLabel:String = "";
      
      public var isHasAction:Boolean = false;
      
      public var isSubscription:Boolean = false;
      
      public var isWotPlusEnabled:Boolean = false;
      
      public var isPremium:Boolean = false;
      
      public var premiumIcon:String = "";
      
      public function HBC_PremDataVo(param1:Object = null)
      {
         super(param1);
      }
   }
}
