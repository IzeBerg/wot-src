package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.core.UIComponent;
   
   public class ArrowDown extends MovieClip implements IDisposable
   {
      
      public static const STATE_NORMAL:String = "normal";
      
      public static const STATE_ACTION:String = "action";
      
      public static const STATE_UP:String = "up";
       
      
      public var bounds:Sprite = null;
      
      private var _statesMap:Object = null;
      
      public function ArrowDown()
      {
         super();
         this._statesMap = UIComponent.generateLabelHash(this);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this._statesMap);
         this._statesMap = null;
         this.bounds = null;
      }
      
      override public function get width() : Number
      {
         return this.bounds.width;
      }
      
      public function set state(param1:String) : void
      {
         App.utils.asserter.assert(this._statesMap[param1],"_statesMap have not state " + param1);
         this.gotoAndStop(param1);
      }
   }
}
