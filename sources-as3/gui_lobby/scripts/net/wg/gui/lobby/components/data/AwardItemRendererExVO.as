package net.wg.gui.lobby.components.data
{
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class AwardItemRendererExVO extends ToolTipVO
   {
      
      private static const COMPENSATION_REASON_FIELD_NAME:String = "compensationReason";
       
      
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
      
      public var compensationReason:AwardItemRendererExVO = null;
      
      public var padding:int = 0;
      
      public function AwardItemRendererExVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == COMPENSATION_REASON_FIELD_NAME)
         {
            if(param2)
            {
               this.compensationReason = new AwardItemRendererExVO(param2);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.compensationReason)
         {
            this.compensationReason.dispose();
            this.compensationReason = null;
         }
         super.onDispose();
      }
   }
}
