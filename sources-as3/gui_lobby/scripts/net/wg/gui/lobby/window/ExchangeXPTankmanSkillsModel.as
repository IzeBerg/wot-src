package net.wg.gui.lobby.window
{
   import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
   
   public class ExchangeXPTankmanSkillsModel extends CarouselTankmanSkillsModel
   {
       
      
      private var _defaultActiveValue:Boolean;
      
      public function ExchangeXPTankmanSkillsModel()
      {
         super();
         this._defaultActiveValue = isActive;
      }
      
      override public function set level(param1:int) : void
      {
         super.level = param1;
         this.reCalcValues();
      }
      
      private function reCalcValues() : void
      {
         if(super.level >= 100)
         {
            isActive = true;
         }
         else
         {
            isActive = this._defaultActiveValue;
         }
      }
      
      public function set defaultActiveValue(param1:Boolean) : void
      {
         this._defaultActiveValue = param1;
         this.reCalcValues();
      }
   }
}
