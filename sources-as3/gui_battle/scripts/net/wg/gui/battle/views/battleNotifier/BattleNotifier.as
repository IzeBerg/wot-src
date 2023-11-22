package net.wg.gui.battle.views.battleNotifier
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IBattleNotifierMeta;
   import net.wg.infrastructure.base.meta.impl.BattleNotifierMeta;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   
   public class BattleNotifier extends BattleNotifierMeta implements IBattleNotifierMeta, IDisplayableComponent
   {
      
      private static const WIDTH:int = 292;
      
      private static const HEIGHT:int = 283;
      
      private static const NORMAL_Y:int = 365;
      
      private static const SMALL_Y:int = 186;
      
      private static const HEIGHT_BREAKPOINT:int = 960;
       
      
      private var _stageHeight:int = 0;
      
      public function BattleNotifier()
      {
         super();
         setManageSize(true);
         this.setSize(WIDTH,HEIGHT);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            this.y = this._stageHeight > HEIGHT_BREAKPOINT ? Number(NORMAL_Y) : Number(SMALL_Y);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         this._stageHeight = param2;
         invalidate(InvalidationType.POSITION);
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         visible = param1;
      }
      
      public function isCompVisible() : Boolean
      {
         return visible;
      }
   }
}
