package net.wg.gui.lobby.profile.pages.technique
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.infrastructure.base.meta.IProfileTechniquePageMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileTechniquePageMeta;
   
   public class ProfileTechniquePage extends ProfileTechniquePageMeta implements IProfileTechniquePageMeta
   {
      
      private static const LAYOUT_INVALID:String = "layoutInv";
      
      private static const GAP_DATA_FIELDS:int = 10;
       
      
      public var checkBoxExistence:CompactCheckBox;
      
      public function ProfileTechniquePage()
      {
         super();
      }
      
      private static function onCheckBoxExistenceRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(PROFILE.SECTION_TECHNIQUE_CHECKBOXHANGARVEHICLES_TOOLTIP);
      }
      
      private static function onCheckBoxExistenceRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override public function as_setInitData(param1:Object) : void
      {
         techniqueInitVO = new TechStatisticsPageInitVO(param1);
         this.applyInitData();
         invalidate(LAYOUT_INVALID);
      }
      
      override protected function applyInitData() : void
      {
         super.applyInitData();
         var _loc1_:TechStatisticsPageInitVO = techniqueInitVO as TechStatisticsPageInitVO;
         App.utils.asserter.assertNotNull(_loc1_,Errors.CANT_NULL);
         this.checkBoxExistence.label = _loc1_.hangarVehiclesLabel;
         this.checkBoxExistence.selected = _loc1_.isInHangarSelected;
         this.checkBoxExistence.validateNow();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.checkBoxExistence.addEventListener(Event.SELECT,this.onCheckBoxExistenceSelectHandler);
         this.checkBoxExistence.addEventListener(MouseEvent.ROLL_OVER,onCheckBoxExistenceRollOverHandler);
         this.checkBoxExistence.addEventListener(MouseEvent.ROLL_OUT,onCheckBoxExistenceRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(isInvalid(LAYOUT_INVALID))
         {
            _loc1_ = battlesDropdown.txtLabel;
            _loc2_ = _loc1_.x + _loc1_.width - _loc1_.textWidth;
            _loc3_ = this.checkBoxExistence.textField;
            _loc4_ = _loc3_.x + _loc3_.textWidth;
            _loc5_ = battlesDropdown.x + _loc2_ - (this.checkBoxExistence.x + _loc4_ + GAP_DATA_FIELDS);
            if(_loc5_ < 0)
            {
               this.checkBoxExistence.x += _loc5_;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.checkBoxExistence.removeEventListener(Event.SELECT,this.onCheckBoxExistenceSelectHandler);
         this.checkBoxExistence.removeEventListener(MouseEvent.ROLL_OVER,onCheckBoxExistenceRollOverHandler);
         this.checkBoxExistence.removeEventListener(MouseEvent.ROLL_OUT,onCheckBoxExistenceRollOutHandler);
         this.checkBoxExistence.dispose();
         this.checkBoxExistence = null;
         super.onDispose();
      }
      
      public function as_setSelectedVehicleIntCD(param1:Number) : void
      {
         listComponent.selectVehicleById(param1);
      }
      
      private function onCheckBoxExistenceSelectHandler(param1:Event) : void
      {
         setIsInHangarSelectedS(this.checkBoxExistence.selected);
      }
   }
}
