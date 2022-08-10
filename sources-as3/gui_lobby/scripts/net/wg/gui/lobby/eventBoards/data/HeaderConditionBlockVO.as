package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HeaderConditionBlockVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var uiIcon1:String = "";
      
      public var uiIcon2:String = "";
      
      public var uiIcon3:String = "";
      
      public var description1:String = "";
      
      public var description2:String = "";
      
      public var description3:String = "";
      
      public var label:String = "";
      
      public var buttonVisible:Boolean = true;
      
      public var description1Tooltip:String = "";
      
      public var description2Tooltip:String = "";
      
      public var description3Tooltip:String = "";
      
      public var buttonTooltip:String = "";
      
      public function HeaderConditionBlockVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
