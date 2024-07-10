package net.wg.gui.battle.comp7.battleloading.renderers
{
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleInfoVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.random.battleloading.renderers.RandomPlayerItemRenderer;
   
   public class Comp7TipPlayerItemRenderer extends RandomPlayerItemRenderer
   {
       
      
      private var _rankIcon:BattleAtlasSprite;
      
      public function Comp7TipPlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
      {
         super(param1,param2,param3);
         var _loc4_:Comp7RendererContainer = param1 as Comp7RendererContainer;
         if(param3)
         {
            this._rankIcon = _loc4_.rankIconsEnemy[param2];
         }
         else
         {
            this._rankIcon = _loc4_.rankIconsAlly[param2];
         }
      }
      
      override protected function setSelfBG() : void
      {
         if(selfBg != null)
         {
            selfBg.visible = UserTags.isCurrentPlayer(model.userTags);
            if(selfBg.visible)
            {
               selfBg.imageName = BATTLEATLAS.BATTLE_LOADING_SELF_TIPS_BACKGROUND;
            }
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Comp7DAAPIVehicleInfoVO = model as Comp7DAAPIVehicleInfoVO;
         if(_loc1_ == null)
         {
            return;
         }
         this._rankIcon.imageName = BATTLEATLAS.DEFAULT_ICON;
         if(_loc1_.isSuperSquad)
         {
            squad.imageName = !!model.isSquadPersonal() ? BATTLEATLAS.SUPER_SQUAD_GOLD : BATTLEATLAS.SUPER_SQUAD_SILVER;
            squad.visible = true;
         }
      }
      
      override protected function onDispose() : void
      {
         this._rankIcon = null;
         super.onDispose();
      }
      
      override public function get isExtendedLayout() : Boolean
      {
         return false;
      }
      
      override public function set isExtendedLayout(param1:Boolean) : void
      {
      }
   }
}
