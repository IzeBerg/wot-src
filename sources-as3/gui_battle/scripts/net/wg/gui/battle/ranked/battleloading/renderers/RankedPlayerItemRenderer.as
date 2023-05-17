package net.wg.gui.battle.ranked.battleloading.renderers
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehicleInfoVO;
   
   public class RankedPlayerItemRenderer extends BasePlayerItemRenderer
   {
       
      
      private var _rankIcon:BattleAtlasSprite;
      
      public function RankedPlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
      {
         super(param1,param2,param3);
         var _loc4_:RankedRendererContainer = param1 as RankedRendererContainer;
         if(param3)
         {
            this._rankIcon = _loc4_.rankIconsEnemy[param2];
         }
         else
         {
            this._rankIcon = _loc4_.rankIconsAlly[param2];
         }
      }
      
      override protected function onDispose() : void
      {
         this._rankIcon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 75
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
   }
}
