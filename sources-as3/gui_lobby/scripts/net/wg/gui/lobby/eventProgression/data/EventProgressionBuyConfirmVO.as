package net.wg.gui.lobby.eventProgression.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventProgressionBuyConfirmVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var content:String = "";
      
      public var titleBig:String = "";
      
      public var contentBig:String = "";
      
      public var buyBtnLabel:String = "";
      
      public var backBtnLabel:String = "";
      
      public var showIcon:Boolean = false;
      
      public function EventProgressionBuyConfirmVO(param1:Object)
      {
         super(param1);
      }
   }
}
