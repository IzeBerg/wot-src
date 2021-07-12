package net.wg.gui.lobby.vehiclePreview.infoPanel.modules
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.lobby.modulesPanel.ModulesPanel;
   import net.wg.infrastructure.base.meta.IVehiclePreviewModulesTabMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewModulesTabMeta;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class VPModulesTab extends VehiclePreviewModulesTabMeta implements IViewStackExContent, IVehiclePreviewModulesTabMeta
   {
      
      private static const STATUS_TF_OFFSET:int = 6;
       
      
      public var modules:ModulesPanel;
      
      public var statusInfoTf:TextField;
      
      public var unlockableModulesTF:TextField;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _statusInfoTooltip:String;
      
      private var _haveUnlockable:Boolean = false;
      
      private var _needToShowAnim:Boolean = false;
      
      public function VPModulesTab()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         this.modules.preferredLayout = PopOverConst.ARROW_LEFT;
         this.modules.addEventListener(Event.RESIZE,this.onModulesResizeHandler);
         this.unlockableModulesTF.text = VEHICLE_PREVIEW.INFOPANEL_TAB_MODULES_UNLOCKABLEMODULES;
         this.statusInfoTf.addEventListener(MouseEvent.ROLL_OVER,this.onStatusInfoTfRollOverHandler);
         this.statusInfoTf.addEventListener(MouseEvent.ROLL_OUT,this.onStatusInfoTfRollOutHandler);
         this.statusInfoTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.statusInfoTf.removeEventListener(MouseEvent.ROLL_OVER,this.onStatusInfoTfRollOverHandler);
         this.statusInfoTf.removeEventListener(MouseEvent.ROLL_OUT,this.onStatusInfoTfRollOutHandler);
         this.statusInfoTf = null;
         this.unlockableModulesTF = null;
         this.modules.removeEventListener(Event.RESIZE,this.onModulesResizeHandler);
         this.modules = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.modules,VEHPREVIEW_CONSTANTS.MODULES_PY_ALIAS);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.statusInfoTf.y = this.modules.y + this.modules.actualHeight + STATUS_TF_OFFSET;
            this.unlockableModulesTF.visible = this._haveUnlockable;
            if(this._needToShowAnim)
            {
               this.modules.playAnimation();
            }
         }
      }
      
      public function as_setStatusInfo(param1:String, param2:String, param3:int, param4:Boolean) : void
      {
         this.statusInfoTf.htmlText = param1;
         this._statusInfoTooltip = param2;
         this._haveUnlockable = param3 == VEHPREVIEW_CONSTANTS.COLLECTIBLE;
         this._needToShowAnim = param4;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setActive(param1:Boolean) : void
      {
         setActiveStateS(param1);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function onModulesResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onStatusInfoTfRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._statusInfoTooltip);
      }
      
      private function onStatusInfoTfRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
