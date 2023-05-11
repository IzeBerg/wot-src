package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.getQualifiedClassName;
   import net.wg.gui.components.advanced.CounterEx;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ILocale;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SeasonResultRenderer extends Sprite implements IDisposable
   {
       
      
      public var counter:CounterEx = null;
      
      public var labelTF:TextField = null;
      
      private var _resultValue:String = null;
      
      private var _locale:ILocale;
      
      private var _baseDisposed:Boolean = false;
      
      public function SeasonResultRenderer()
      {
         this._locale = App.utils.locale;
         super();
         this.labelTF.mouseEnabled = this.labelTF.mouseWheelEnabled = false;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            App.utils.asserter.assert(false,name + "(" + getQualifiedClassName(this) + ") already disposed!");
         }
         this._baseDisposed = true;
         this.onDispose();
      }
      
      public function setLabel(param1:String) : void
      {
         this.labelTF.text = param1;
      }
      
      public function setValue(param1:String) : void
      {
         this._resultValue = param1;
      }
      
      public function updateValue() : void
      {
         var _loc1_:IFormattedInt = null;
         this.counter.visible = StringUtils.isNotEmpty(this._resultValue);
         if(this.counter.visible)
         {
            _loc1_ = this._locale.parseFormattedInteger(this._resultValue);
            this.counter.init(_loc1_.value,this._resultValue,_loc1_.delimiter,true);
            this.counter.x = this.counter.expectedWidth >> 1;
         }
      }
      
      protected function onDispose() : void
      {
         this.counter.dispose();
         this.counter = null;
         this.labelTF = null;
         this._locale = null;
      }
      
      public function set endingChar(param1:String) : void
      {
         this.counter.endingChar = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
