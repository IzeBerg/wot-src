package net.wg.gui.lobby.hangar.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AlertMessageBlockVO extends DAAPIDataClass
   {
       
      
      public var alertIcon:String = "";
      
      public var buttonIcon:String = "";
      
      public var buttonTooltip:String = "";
      
      public var buttonVisible:Boolean = true;
      
      public var buttonLabel:String = "";
      
      public var statusText:String = "";
      
      public var popoverAlias:String = "";
      
      public var bgVisible:Boolean = true;
      
      public var shadowFilterVisible:Boolean = true;
      
      public var tooltip:String = "";
      
      public var isSimpleTooltip:Boolean = false;
      
      public var isWulfTooltip:Boolean = false;
      
      public function AlertMessageBlockVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
