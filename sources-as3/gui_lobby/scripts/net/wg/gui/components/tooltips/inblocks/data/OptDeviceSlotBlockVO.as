package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.data.ImageRendererVO;
   import net.wg.gui.lobby.questsWindow.data.PaddingsVO;
   
   public class OptDeviceSlotBlockVO extends DAAPIDataClass
   {
      
      private static const OVERLAY_PADDING_FIELD_NAME:String = "overlayPadding";
      
      private static const HIGHLIGHT_PADDING_FIELD_NAME:String = "highlightPadding";
      
      private static const DEVICE_SPECS_FIELD_NAME:String = "deviceSpecs";
      
      private static const SLOT_SPECS_FIELD_NAME:String = "slotSpecs";
       
      
      public var imagePath:String = "";
      
      public var overlayPath:String = "";
      
      public var highlightPath:String = "";
      
      public var overlayPadding:PaddingsVO = null;
      
      public var highlightPadding:PaddingsVO = null;
      
      public var slotState:String = "";
      
      public var showSlotHighlight:Boolean = false;
      
      public var showUpArrow:Boolean = false;
      
      public var slotAlpha:Number = 1;
      
      public var specsGap:int = -32;
      
      public var slotSpecsOffset:int = 16;
      
      public var deviceSpecsOffset:int = 40;
      
      private var _slotSpecs:Vector.<ImageRendererVO> = null;
      
      private var _deviceSpecs:Vector.<ImageRendererVO> = null;
      
      public function OptDeviceSlotBlockVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == DEVICE_SPECS_FIELD_NAME && param2 != null)
         {
            this._deviceSpecs = Vector.<ImageRendererVO>(App.utils.data.convertVOArrayToVector(param1,param2,ImageRendererVO));
            return false;
         }
         if(param1 == SLOT_SPECS_FIELD_NAME && param2 != null)
         {
            this._slotSpecs = Vector.<ImageRendererVO>(App.utils.data.convertVOArrayToVector(param1,param2,ImageRendererVO));
            return false;
         }
         if(param1 == OVERLAY_PADDING_FIELD_NAME && param2 != null)
         {
            this.overlayPadding = new PaddingsVO(param2);
            return false;
         }
         if(param1 == HIGHLIGHT_PADDING_FIELD_NAME && param2 != null)
         {
            this.highlightPadding = new PaddingsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._deviceSpecs != null)
         {
            this._deviceSpecs.fixed = false;
            this._deviceSpecs.splice(0,this._deviceSpecs.length);
            this._deviceSpecs = null;
         }
         if(this._slotSpecs != null)
         {
            this._slotSpecs.fixed = false;
            this._slotSpecs.splice(0,this._slotSpecs.length);
            this._slotSpecs = null;
         }
         if(this.overlayPadding != null)
         {
            this.overlayPadding.dispose();
            this.overlayPadding = null;
         }
         if(this.highlightPadding != null)
         {
            this.highlightPadding.dispose();
            this.highlightPadding = null;
         }
         super.onDispose();
      }
      
      public function getSlotSpecs() : Vector.<ImageRendererVO>
      {
         return this._slotSpecs;
      }
      
      public function getDeviceSpecs() : Vector.<ImageRendererVO>
      {
         return this._deviceSpecs;
      }
   }
}
