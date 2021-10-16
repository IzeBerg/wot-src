package net.wg.gui.battle.ranked.battleloading
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_TYPES;
   import net.wg.gui.battle.battleloading.BattleLoadingForm;
   import net.wg.gui.battle.battleloading.BattleLoadingHelper;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.ranked.battleloading.renderers.TablePlayerItemRenderer;
   import net.wg.gui.battle.ranked.battleloading.renderers.TipPlayerItemRenderer;
   import net.wg.utils.IClassFactory;
   
   public class BattleLoadingForm extends net.wg.gui.battle.battleloading.BattleLoadingForm
   {
       
      
      public function BattleLoadingForm()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG Ranked BattleLoadingForm " + name + "]";
      }
      
      override protected function getRendererClass(param1:VisualTipInfoVO) : Class
      {
         return param1.settingID == BattleLoadingHelper.SETTING_TEXT ? TablePlayerItemRenderer : TipPlayerItemRenderer;
      }
      
      override protected function getRenderersContainerInstance(param1:VisualTipInfoVO) : BaseRendererContainer
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         var _loc3_:String = param1.settingID == BattleLoadingHelper.SETTING_TEXT ? Linkages.RANKED_BATTLE_LOADING_TABLE_RENDERERS : Linkages.RANKED_BATTLE_LOADING_TIPS_RENDERERS;
         return _loc2_.getComponent(_loc3_,BaseRendererContainer);
      }
      
      override protected function getBattleTypeName() : String
      {
         return BATTLE_TYPES.RANKED;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         leftSquad.imageName = BATTLEATLAS.ICON_RANK;
         rightSquad.imageName = BATTLEATLAS.ICON_RANK;
      }
   }
}
