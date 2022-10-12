package net.wg.gui.battle.comp7.battleloading
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_TYPES;
   import net.wg.gui.battle.battleloading.BattleLoadingForm;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.comp7.battleloading.renderers.Comp7TipPlayerItemRenderer;
   import net.wg.utils.IClassFactory;
   
   public class Comp7BattleLoadingForm extends BattleLoadingForm
   {
      
      private static const RENDERERS_COUNT:uint = 7;
       
      
      public function Comp7BattleLoadingForm()
      {
         super();
      }
      
      override public function setFormDisplayData(param1:VisualTipInfoVO) : void
      {
         super.setFormDisplayData(param1);
         formBackgroundTable.imageName = BATTLEATLAS.BATTLE_LOADING_FORM_BG_TIPS_7X7;
      }
      
      override public function toString() : String
      {
         return "[WG Comp7 BattleLoadingForm " + name + "]";
      }
      
      override protected function getRendererClass(param1:VisualTipInfoVO) : Class
      {
         return Comp7TipPlayerItemRenderer;
      }
      
      override protected function getRenderersContainerInstance(param1:VisualTipInfoVO) : BaseRendererContainer
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         return _loc2_.getComponent(Linkages.COMP7_BATTLE_LOADING_TIPS_RENDERERS,BaseRendererContainer);
      }
      
      override protected function getBattleTypeName() : String
      {
         return BATTLE_TYPES.COMP7;
      }
      
      override protected function getRenderersCount() : uint
      {
         return RENDERERS_COUNT;
      }
   }
}
