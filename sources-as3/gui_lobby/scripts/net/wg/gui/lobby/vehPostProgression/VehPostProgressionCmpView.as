package net.wg.gui.lobby.vehPostProgression
{
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.infrastructure.base.meta.IVehiclePostProgressionCmpViewMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePostProgressionCmpViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehPostProgressionCmpView extends VehiclePostProgressionCmpViewMeta implements IVehiclePostProgressionCmpViewMeta
   {
      
      private static const OFFSET:int = 34;
       
      
      public var closeBtn:CloseButtonText = null;
      
      public function VehPostProgressionCmpView()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(injectComponent,HANGAR_ALIASES.POST_PROGRESSION_CMP_INJECT);
      }
      
      override protected function onEscapeClickHandler() : void
      {
         onCloseClickS();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.closeBtn.x = width - this.closeBtn.width - OFFSET;
         }
      }
      
      override protected function onDispose() : void
      {
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.closeBtn.validateNow();
         _vehicleBlock.mouseChildren = _vehicleBlock.mouseEnabled = false;
         title.mouseChildren = title.mouseEnabled = false;
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onCloseClickS();
      }
   }
}
