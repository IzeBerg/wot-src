package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ModuleIcon extends UIComponentEx
   {
       
      
      public var moduleType:ModuleTypesUIWithFill;
      
      public var artefact:UILoaderAlt;
      
      public var moduleLevel:MovieClip;
      
      public var equipSlotHighlight:MovieClip = null;
      
      public var equipSlotOverlay:MovieClip = null;
      
      public function ModuleIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.moduleType.dispose();
         this.moduleType = null;
         this.artefact.dispose();
         this.artefact = null;
         this.moduleLevel = null;
         this.equipSlotHighlight = null;
         this.equipSlotOverlay = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.equipSlotHighlight.mouseEnabled = this.equipSlotOverlay.mouseEnabled = false;
      }
      
      public function setHighlightType(param1:String) : void
      {
         var _loc2_:Boolean = StringUtils.isNotEmpty(param1);
         this.equipSlotHighlight.visible = _loc2_;
         if(_loc2_)
         {
            this.equipSlotHighlight.gotoAndStop(param1);
         }
      }
      
      public function setOverlayType(param1:String) : void
      {
         var _loc2_:Boolean = StringUtils.isNotEmpty(param1);
         this.equipSlotOverlay.visible = _loc2_;
         if(_loc2_)
         {
            this.equipSlotOverlay.gotoAndStop(param1);
         }
      }
      
      public function setValueLabel(param1:String, param2:Number) : void
      {
         if(param2 > 0)
         {
            this.setValuesWithType(FITTING_TYPES.MODULE,param1,param2);
         }
         else
         {
            this.setValuesWithType(FITTING_TYPES.EQUIPMENT,param1,0);
         }
      }
      
      public function setValuesWithType(param1:String, param2:String, param3:int) : void
      {
         this.moduleType.visible = false;
         this.moduleLevel.gotoAndStop(1);
         this.moduleLevel.visible = false;
         this.artefact.unload();
         this.artefact.visible = false;
         if(param1 == FITTING_TYPES.MODULE)
         {
            this.showItemInModuleType(param2);
            this.showLevel(param3);
         }
         else if(param1 == FITTING_TYPES.SHELL || param1 == FITTING_TYPES.EQUIPMENT || param1 == FITTING_TYPES.OPTIONAL_DEVICE || param1 == FITTING_TYPES.BOOSTER)
         {
            this.showItemInModuleType(param2);
         }
         else if(param1 == FITTING_TYPES.ORDER)
         {
            this.showItemInArtefact(param2);
            this.showLevel(param3);
         }
         else
         {
            this.showItemInArtefact(param2);
         }
      }
      
      private function showItemInModuleType(param1:String) : void
      {
         this.moduleType.setModuleTypeIcon(param1);
         this.moduleType.visible = true;
      }
      
      private function showItemInArtefact(param1:String) : void
      {
         this.artefact.visible = true;
         this.artefact.source = param1;
      }
      
      private function showLevel(param1:int) : void
      {
         this.moduleLevel.visible = true;
         this.moduleLevel.gotoAndStop(param1);
      }
   }
}
