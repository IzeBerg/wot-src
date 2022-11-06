package net.wg.gui.battle.views.directionIndicator
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class BaseValueIndicator extends Sprite implements IDisposable
   {
      
      private static const EMPTY_STR:String = Values.EMPTY_STR;
       
      
      public var greenTF:TextField = null;
      
      public var redTF:TextField = null;
      
      public var purpleTF:TextField = null;
      
      public var yellowTF:TextField = null;
      
      private var _currTF:TextField = null;
      
      private var _value:String = "";
      
      private var _align:String = "center";
      
      private var _disposed:Boolean = false;
      
      public function BaseValueIndicator()
      {
         super();
         this.greenTF.visible = false;
         this.redTF.visible = false;
         this.purpleTF.visible = false;
         this.yellowTF.visible = false;
         TextFieldEx.setNoTranslate(this.greenTF,true);
         TextFieldEx.setNoTranslate(this.redTF,true);
         TextFieldEx.setNoTranslate(this.purpleTF,true);
         TextFieldEx.setNoTranslate(this.yellowTF,true);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.greenTF = null;
         this.redTF = null;
         this.purpleTF = null;
         this.yellowTF = null;
         this._currTF = null;
      }
      
      public function setValue(param1:String) : void
      {
         if(!param1 || param1 == this._value)
         {
            return;
         }
         this._value = param1;
         if(this._currTF)
         {
            this.updateValue();
         }
      }
      
      public function setShape(param1:String) : void
      {
         if(param1 == this._value)
         {
            return;
         }
         if(this._currTF)
         {
            this._currTF.visible = false;
         }
         switch(param1)
         {
            case DirectionIndicatorShape.SHAPE_GREEN:
               this._currTF = this.greenTF;
               break;
            case DirectionIndicatorShape.SHAPE_RED:
               this._currTF = this.redTF;
               break;
            case DirectionIndicatorShape.SHAPE_PURPLE:
               this._currTF = this.purpleTF;
               break;
            case DirectionIndicatorShape.SHAPE_YELLOW:
               this._currTF = this.yellowTF;
               break;
            default:
               return;
         }
         this._currTF.visible = true;
         this.updateValue();
      }
      
      public function setAlign(param1:String) : void
      {
         if(param1 == this._align)
         {
            return;
         }
         this.applyTextAlign(this.greenTF,param1);
         this.applyTextAlign(this.redTF,param1);
         this.applyTextAlign(this.purpleTF,param1);
         this.applyTextAlign(this.yellowTF,param1);
         this._align = param1;
      }
      
      protected function updateValue() : void
      {
         this._currTF.text = this._value;
      }
      
      private function applyTextAlign(param1:TextField, param2:String) : void
      {
         var _loc3_:TextFormat = param1.defaultTextFormat;
         _loc3_.align = param2;
         param1.defaultTextFormat = _loc3_;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
