package net.wg.gui.tutorial.controls
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.constants.generated.BATTLE_TYPES;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseTipLoadingForm extends TipLoadingForm
   {
      
      private static const MSG_MUST_BE_OVERRIDEN:String = "Method must be overridden!";
       
      
      public function BaseTipLoadingForm()
      {
         super();
      }
      
      public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         this.throwAbstractException();
      }
      
      public function getMapComponent() : MinimapPresentation
      {
         this.throwAbstractException();
         return null;
      }
      
      public function setFormDisplayData(param1:VisualTipInfoVO) : void
      {
         this.throwAbstractException();
      }
      
      public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         this.throwAbstractException();
      }
      
      public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         this.throwAbstractException();
      }
      
      public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         this.throwAbstractException();
      }
      
      public function setVehiclesData(param1:Boolean, param2:Array, param3:Vector.<Number>) : void
      {
         this.throwAbstractException();
      }
      
      public function updateTeamsHeaders(param1:String, param2:String) : void
      {
         this.throwAbstractException();
      }
      
      public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         this.throwAbstractException();
      }
      
      protected function getBattleTypeName() : String
      {
         return BATTLE_TYPES.RANDOM;
      }
      
      private function throwAbstractException() : void
      {
         DebugUtils.LOG_ERROR(MSG_MUST_BE_OVERRIDEN);
         throw new AbstractException(MSG_MUST_BE_OVERRIDEN);
      }
   }
}
