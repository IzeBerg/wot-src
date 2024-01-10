package net.wg.gui.battle.random.battleloading.renderers
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.renderers.BasePlayerItemRenderer;
   import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   
   public class RandomPlayerItemRenderer extends BasePlayerItemRenderer
   {
       
      
      protected var squad:BattleAtlasSprite;
      
      private var _defaultSquadPositionX:int;
      
      public function RandomPlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
      {
         super(param1,param2,param3);
         var _loc4_:RandomRendererContainer = param1 as RandomRendererContainer;
         if(param3)
         {
            this.squad = _loc4_.squadsEnemy[param2];
         }
         else
         {
            this.squad = _loc4_.squadsAlly[param2];
         }
         this._defaultSquadPositionX = this.squad.x;
      }
      
      override protected function onDispose() : void
      {
         this.squad = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(model && model.isSquadMan())
         {
            this.squad.visible = true;
            if(model.isSquadPersonal())
            {
               this.squad.imageName = BATTLEATLAS.squad_gold(model.squadIndex.toString());
            }
            else
            {
               this.squad.imageName = BATTLEATLAS.squad_silver(model.squadIndex.toString());
            }
         }
         else
         {
            this.squad.visible = false;
         }
      }
      
      override protected function updateLayout() : void
      {
         super.updateLayout();
         this.squad.x = this._defaultSquadPositionX;
         if(isExtendedLayout)
         {
            this.squad.x += !!isEnemy ? PRESTIGE_LEVEL_OFFSET : -PRESTIGE_LEVEL_OFFSET;
         }
      }
   }
}
