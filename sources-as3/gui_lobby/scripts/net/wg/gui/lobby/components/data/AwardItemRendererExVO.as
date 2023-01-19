package net.wg.gui.lobby.components.data
{
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class AwardItemRendererExVO extends ToolTipVO
   {
       
      
      public var imgSource:String = "";
      
      public var label:String = "";
      
      public var align:String = "center";
      
      public var compensationTooltip:String = "";
      
      public var hasCompensation:Boolean = false;
      
      public var hasAnimation:Boolean = false;
      
      public var isObtained:Boolean = false;
      
      public var obtainedImage:String = "";
      
      public var highlightType:String = "";
      
      public var overlayType:String = "";
      
      public var gap:int = 0;
      
      public var obtainedImageOffset:int = 0;
      
      public var areTokensPawned:Boolean = false;
      
      public var tokensPawnedImage:String = "";
      
      public var itemName:String = "";
      
      public var highlightIcon:String = "";
      
      public var overlayIcon:String = "";
      
      public var compensationReason:Object = null;
      
      public var padding:int = 0;
      
      public function AwardItemRendererExVO(param1:Object)
      {
         super(param1);
      }
   }
}
