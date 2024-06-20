package net.wg.gui.components.common.markers
{
   public class HealthBarAnimatedLabel extends HealthBarAnimatedPart
   {
      
      private static const INVALIDATE_DAMAGE:String = "invalidateDamage";
       
      
      public var damageLabel:DamageLabel;
      
      private var _damage:Number;
      
      private var _fakeDamage:Number;
      
      private var _imitation:Boolean = false;
      
      private var _imitationFlag:String = "";
      
      public function HealthBarAnimatedLabel()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_DAMAGE))
         {
            this.imitationDamage(this.imitation,this.fakeDamage,this.imitationFlag);
         }
      }
      
      public function damage(param1:Number, param2:String) : void
      {
         if(tweenState != INACTIVE_STATE && tweenState != IMITATION_STATE)
         {
            this._damage += param1;
         }
         else
         {
            this._damage = param1;
         }
         this.damageLabel.color = param2;
         this.damageLabel.text = this._damage > 0 ? String(-this._damage) : "";
      }
      
      public function imitationDamage(param1:Boolean, param2:Number, param3:String) : void
      {
         if(param1)
         {
            this.damage(param2,param3);
            tweenState = IMITATION_STATE;
            setState();
         }
         visible = param1;
      }
      
      public function get fakeDamage() : Number
      {
         return this._fakeDamage;
      }
      
      public function set fakeDamage(param1:Number) : void
      {
         if(this._fakeDamage == param1)
         {
            return;
         }
         this._fakeDamage = param1;
         invalidate(INVALIDATE_DAMAGE);
      }
      
      public function get imitationFlag() : String
      {
         return this._imitationFlag;
      }
      
      public function set imitationFlag(param1:String) : void
      {
         if(param1 == this._imitationFlag)
         {
            return;
         }
         this._imitationFlag = param1;
         invalidate(INVALIDATE_DAMAGE);
      }
      
      public function get imitation() : Boolean
      {
         return this._imitation;
      }
      
      public function set imitation(param1:Boolean) : void
      {
         if(this._imitation == param1)
         {
            return;
         }
         this._imitation = param1;
         invalidate(INVALIDATE_DAMAGE);
      }
   }
}
