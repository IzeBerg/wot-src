package net.wg.gui.components.icons
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleTypeIcon extends UIComponentEx
   {
      
      public static const TYPE_NEUTRAL:String = "neutral";
      
      public static const TYPE_TRAINING:String = "training";
       
      
      private var _type:String = "neutral";
      
      public function BattleTypeIcon()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            super.gotoAndStop(this._type);
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(param1 == this._type)
         {
            return;
         }
         this._type = param1;
         invalidateState();
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         if(param1 is String)
         {
            this._type = param1 as String;
         }
         super.gotoAndStop(param1,param2);
      }
   }
}
