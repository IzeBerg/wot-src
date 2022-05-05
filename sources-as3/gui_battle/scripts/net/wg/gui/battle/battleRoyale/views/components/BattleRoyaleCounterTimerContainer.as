package net.wg.gui.battle.battleRoyale.views.components
{
   import net.wg.gui.battle.views.destroyTimers.components.SecondaryTimerContainer;
   
   public class BattleRoyaleCounterTimerContainer extends SecondaryTimerContainer
   {
      
      private static const FULL_SIZE_TEXTFIELD_X:int = 39;
      
      private static const SMALL_SIZE_TEXTFIELD_X:int = 33;
       
      
      public var counter:BattleRoyaleCounterTimerAnimation;
      
      public function BattleRoyaleCounterTimerContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this.counter)
         {
            this.counter.dispose();
            this.counter = null;
         }
         super.onDispose();
      }
      
      public function updateCounterData(param1:String, param2:int) : void
      {
         if(this.counter)
         {
            this.counter.setData(param1,param2);
         }
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         textFieldLabel.visible = !param1;
         textField.x = !!param1 ? Number(SMALL_SIZE_TEXTFIELD_X) : Number(FULL_SIZE_TEXTFIELD_X);
         if(this.counter)
         {
            this.counter.isSmall = param1;
            this.counter.x = !!param1 ? Number(SMALL_SIZE_TEXTFIELD_X) : Number(FULL_SIZE_TEXTFIELD_X);
         }
      }
   }
}
