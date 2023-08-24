package net.wg.gui.battle.comp7.battleloading.renderers
{
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleInfoVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.random.battleloading.renderers.RandomPlayerItemRenderer;
   import org.idmedia.as3commons.util.StringUtils;
   
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
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         super.draw();
         var _loc1_:Comp7DAAPIVehicleInfoVO = model as Comp7DAAPIVehicleInfoVO;
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.rank;
         _loc3_ = _loc1_.rankDivision;
         _loc4_ = StringUtils.isNotEmpty(_loc2_) && StringUtils.isNotEmpty(_loc3_);
         this._rankIcon.visible = _loc4_ || _loc1_.isQualification;
         if(_loc4_)
         {
            this._rankIcon.imageName = BATTLEATLAS.getRankIcon(_loc2_,_loc3_);
         }
         else if(_loc1_.isQualification)
         {
            this._rankIcon.imageName = BATTLEATLAS.QUALIFICATION_22X22;
         }
      }
      
      override protected function onDispose() : void
      {
         this._rankIcon = null;
         super.onDispose();
      }
   }
}
