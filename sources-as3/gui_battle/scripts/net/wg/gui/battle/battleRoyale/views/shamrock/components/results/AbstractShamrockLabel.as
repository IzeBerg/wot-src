package net.wg.gui.battle.battleRoyale.views.shamrock.components.results
{
   import com.gskinner.motion.GTweener;
   import com.gskinner.motion.easing.Cubic;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AbstractShamrockLabel extends BattleUIComponent
   {
      
      private static const TWEEN_DURATION:Number = 0.5;
       
      
      public var valueTF:TextField = null;
      
      public var labelTF:TextField = null;
      
      protected var _maxValueWidth:int = 0;
      
      private var _labelValue:int = 0;
      
      private var _labelPrefix:String = "";
      
      public function AbstractShamrockLabel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         GTweener.removeTweens(this);
         this.valueTF = null;
         this.labelTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.alignContent();
         }
      }
      
      public function seMaxValue(param1:int) : void
      {
         this.valueTF.text = this._labelPrefix + param1.toString();
         this._maxValueWidth = this.valueTF.textWidth;
         this.valueTF.text = this._labelPrefix + this._labelValue.toString();
      }
      
      public function setPrefix(param1:String) : void
      {
         this._labelPrefix = param1;
      }
      
      public function setValue(param1:int, param2:Boolean = false) : void
      {
         GTweener.removeTweens(this);
         if(!param2)
         {
            this.labelValue = param1;
         }
         else
         {
            GTweener.to(this,TWEEN_DURATION,{"labelValue":param1},{"ease":Cubic.easeOut});
         }
      }
      
      protected function alignContent() : void
      {
         throw new AbstractException("AbstractShamrockLabel.alignContent" + Errors.ABSTRACT_INVOKE);
      }
      
      public function get labelValue() : Number
      {
         return this._labelValue;
      }
      
      public function set labelValue(param1:Number) : void
      {
         this._labelValue = param1;
         this.valueTF.text = this._labelPrefix + this._labelValue.toString();
         App.utils.commons.updateTextFieldSize(this.valueTF,true,true);
         invalidateSize();
      }
   }
}
