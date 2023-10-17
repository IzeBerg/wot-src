package net.wg.gui.battle.random.battleloading.renderers
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   
   public class RandomPlayerItemRenderer extends BasePlayerItemRenderer
   {
       
      
      private var _squad:BattleAtlasSprite;
      
      private var _defaultSquadPositionX:int;
      
      public function RandomPlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
      {
         super(param1,param2,param3);
         var _loc4_:RandomRendererContainer = param1 as RandomRendererContainer;
         if(param3)
         {
            this._squad = _loc4_.squadsEnemy[param2];
         }
         else
         {
            this._squad = _loc4_.squadsAlly[param2];
         }
         this._defaultSquadPositionX = this._squad.x;
      }
      
      override protected function onDispose() : void
      {
         this._squad = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(model && model.isSquadMan())
         {
            this._squad.visible = true;
            if(model.isSquadPersonal())
            {
               this._squad.imageName = BATTLEATLAS.squad_gold(model.squadIndex.toString());
            }
            else
            {
               this._squad.imageName = BATTLEATLAS.squad_silver(model.squadIndex.toString());
            }
         }
         else
         {
            this._squad.visible = false;
         }
      }
      
      override protected function updateLayout() : void
      {
         super.updateLayout();
         this._squad.x = this._defaultSquadPositionX;
         if(isExtendedLayout)
         {
            this._squad.x += !!isEnemy ? PRESTIGE_LEVEL_OFFSET : -PRESTIGE_LEVEL_OFFSET;
         }
      }
   }
}
