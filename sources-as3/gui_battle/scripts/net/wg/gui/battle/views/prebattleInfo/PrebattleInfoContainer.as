package net.wg.gui.battle.views.prebattleInfo
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.interfaces.IBattleInfo;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PrebattleInfoContainer extends Sprite implements IDisposable
   {
       
      
      private var _linkage:String = "";
      
      private var _info:IBattleInfo = null;
      
      private var _hasInfo:Boolean = false;
      
      private var _hint:String = "";
      
      private var _disposed:Boolean = false;
      
      public function PrebattleInfoContainer()
      {
         super();
      }
      
      public function addInfo(param1:String, param2:Object) : void
      {
         if(param1 == Values.EMPTY_STR)
         {
            this.release();
            return;
         }
         if(this._linkage != param1)
         {
            this.release();
            this._linkage = param1;
            this._info = IBattleInfo(App.utils.classFactory.getObject(param1));
            addChild(DisplayObject(this._info));
            this._hasInfo = true;
         }
         if(this._hasInfo)
         {
            this._info.setData(param2);
            this._info.setHint(this._hint);
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.release();
      }
      
      public function hideByTimer() : void
      {
         if(this._hasInfo)
         {
            this._info.hideByTimer();
         }
      }
      
      public function hideInfo() : void
      {
         if(this._hasInfo)
         {
            this._info.hideInfo();
         }
      }
      
      public function resetByTimer() : void
      {
         if(this._hasInfo)
         {
            this._info.resetByTimer();
         }
      }
      
      public function setHint(param1:String) : void
      {
         if(this._hint == param1)
         {
            return;
         }
         this._hint = param1;
         if(this._hasInfo)
         {
            this._info.setHint(this._hint);
         }
      }
      
      public function showInfo() : Boolean
      {
         if(this._hasInfo)
         {
            this._info.showInfo();
            return true;
         }
         return false;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         if(this._hasInfo)
         {
            this._info.updateStage(param1,param2);
         }
      }
      
      private function release() : void
      {
         if(this._hasInfo)
         {
            removeChild(DisplayObject(this._info));
            this._info.dispose();
            this._info = null;
            this._hasInfo = false;
         }
      }
      
      public function get isInfoHasAnimation() : Boolean
      {
         if(this._hasInfo)
         {
            return this._info.hasAnimation;
         }
         return false;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
