package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FlagContainer extends Sprite implements IDisposable
   {
      
      private static const LINKAGE_FLAG_GREEN:String = "FlagGreenUI";
      
      private static const LINKAGE_FLAG_RED:String = "FlagRedUI";
      
      private static const LINKAGE_FLAG_PURPLE:String = "FlagPurpleUI";
       
      
      private var _flagGreen:MovieClip = null;
      
      private var _flagRed:MovieClip = null;
      
      private var _flagPurple:MovieClip = null;
      
      private var _currFlag:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function FlagContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._flagGreen = null;
         this._flagRed = null;
         this._flagPurple = null;
         this._currFlag = null;
      }
      
      public function showGreen() : void
      {
         this._flagGreen = this.showFlag(this._flagGreen,LINKAGE_FLAG_GREEN);
      }
      
      public function showRed() : void
      {
         this._flagRed = this.showFlag(this._flagRed,LINKAGE_FLAG_RED);
      }
      
      public function showPurple() : void
      {
         this._flagPurple = this.showFlag(this._flagPurple,LINKAGE_FLAG_PURPLE);
      }
      
      public function hide() : void
      {
         if(this._currFlag)
         {
            this._currFlag.visible = false;
            this._currFlag = null;
         }
      }
      
      private function showFlag(param1:MovieClip, param2:String) : MovieClip
      {
         var flagClass:Class = null;
         var flag:MovieClip = param1;
         var linkage:String = param2;
         if(this._currFlag && flag == this._currFlag)
         {
            return flag;
         }
         if(flag)
         {
            flag.visible = true;
         }
         else
         {
            try
            {
               flagClass = getDefinitionByName(linkage) as Class;
               flag = new flagClass();
               addChild(flag);
            }
            catch(error:ReferenceError)
            {
               DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + linkage);
            }
         }
         this._currFlag = flag;
         return flag;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
