package net.wg.gui.utils
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.utils.IFramesHelper;
   
   public class FrameHelper implements IFramesHelper
   {
      
      public static const NOT_EXIST_INDEX:int = -1;
       
      
      private var _target:MovieClip = null;
      
      private var _frames:Object = null;
      
      private var _scriptOnFrames:Vector.<int> = null;
      
      public function FrameHelper(param1:MovieClip)
      {
         var _loc2_:FrameLabel = null;
         super();
         App.utils.asserter.assertNotNull(param1,Errors.CANT_NULL);
         this._target = param1;
         this._frames = {};
         for each(_loc2_ in param1.currentLabels)
         {
            this._frames[_loc2_.name] = _loc2_.frame;
         }
         this._scriptOnFrames = new Vector.<int>();
      }
      
      public function addScriptToFrame(param1:int, param2:Function) : void
      {
         App.utils.asserter.assertNotNull(this._target,Errors.CANT_NULL);
         param1--;
         this._target.addFrameScript(param1,param2);
         this._scriptOnFrames.push(param1);
      }
      
      public function clearFrameScripts() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._target)
         {
            _loc1_ = this._scriptOnFrames.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._target.addFrameScript(this._scriptOnFrames[_loc2_],null);
               _loc2_++;
            }
            this._scriptOnFrames.splice(0,_loc1_);
         }
      }
      
      public function dispose() : void
      {
         this.clearFrameScripts();
         App.utils.data.cleanupDynamicObject(this._frames);
         this._target = null;
         this._frames = null;
         this._scriptOnFrames = null;
      }
      
      public function getFrameBeforeLabel(param1:String) : int
      {
         var _loc2_:int = this.getFrameByLabel(param1);
         return _loc2_ != NOT_EXIST_INDEX && _loc2_ > 0 ? int(_loc2_ - 1) : int(NOT_EXIST_INDEX);
      }
      
      public function getFrameByLabel(param1:String) : int
      {
         var _loc2_:Boolean = this._frames.hasOwnProperty(param1);
         if(_loc2_)
         {
         }
         return !!_loc2_ ? int(this._frames[param1]) : int(NOT_EXIST_INDEX);
      }
      
      public function removeScriptFromFrame(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this._target,Errors.CANT_NULL);
         param1--;
         this._target.addFrameScript(param1,null);
         this._scriptOnFrames.splice(this._scriptOnFrames.indexOf(param1),1);
      }
      
      public function setTarget(param1:MovieClip) : void
      {
         this.clearFrameScripts();
         this._target = param1;
      }
   }
}
