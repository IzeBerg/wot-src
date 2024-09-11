package net.wg.gui.battle.random.views.fragCorrelationBar.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TierGroupingElement extends MovieClip implements IDisposable
   {
      
      private static const TIER_ROMAN_1:String = "I";
      
      private static const TIER_ROMAN_2:String = "II";
      
      private static const TIER_ROMAN_3:String = "III";
      
      private static const TIER_ROMAN_4:String = "IV";
      
      private static const TIER_ROMAN_5:String = "V";
      
      private static const TIER_ROMAN_6:String = "VI";
      
      private static const TIER_ROMAN_7:String = "VII";
      
      private static const TIER_ROMAN_8:String = "VIII";
      
      private static const TIER_ROMAN_9:String = "IX";
      
      private static const TIER_ROMAN_10:String = "X";
      
      private static const TIER_ROMAN_11:String = "XI";
       
      
      public var mainTF:TextField = null;
      
      private var _int_2_roman:Vector.<String> = null;
      
      private var _disposed:Boolean = false;
      
      public function TierGroupingElement()
      {
         super();
         this._int_2_roman = new <String>[TIER_ROMAN_1,TIER_ROMAN_2,TIER_ROMAN_3,TIER_ROMAN_4,TIER_ROMAN_5,TIER_ROMAN_6,TIER_ROMAN_7,TIER_ROMAN_8,TIER_ROMAN_9,TIER_ROMAN_10,TIER_ROMAN_11];
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.mainTF = null;
         this._int_2_roman.splice(0,this._int_2_roman.length);
         this._int_2_roman = null;
      }
      
      public function setTierLevel(param1:int) : void
      {
         var _loc2_:int = param1 - 1;
         if(_loc2_ >= 0 && _loc2_ < this._int_2_roman.length)
         {
            this.mainTF.text = this._int_2_roman[_loc2_];
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
