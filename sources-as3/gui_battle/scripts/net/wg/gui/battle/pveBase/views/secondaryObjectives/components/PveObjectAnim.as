package net.wg.gui.battle.pveBase.views.secondaryObjectives.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.data.PveObjectVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PveObjectAnim extends MovieClip implements IDisposable
   {
      
      private static const SHOW_LABEL:String = "show";
      
      private static const HIDE_LABEL:String = "hide";
      
      private static const HIDE_GREEN_LABEL:String = "hideGreen";
       
      
      public var pveObject:PveObject = null;
      
      private var _id:String = "";
      
      private var _disposed:Boolean = false;
      
      public function PveObjectAnim()
      {
         super();
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function setData(param1:PveObjectVO) : void
      {
         this._id = param1.id;
         this.pveObject.setData(param1);
         gotoAndPlay(SHOW_LABEL);
      }
      
      public function hide(param1:String) : void
      {
         gotoAndPlay(param1);
         if(param1 != HIDE_LABEL)
         {
            this.pveObject.setDone(param1 == HIDE_GREEN_LABEL);
         }
      }
      
      public function setProgressBarValue(param1:int) : void
      {
         this.pveObject.setProgressBarValue(param1);
      }
      
      public function updateTime(param1:String, param2:Boolean) : void
      {
         this.pveObject.updateTime(param1,param2);
      }
      
      public function setAlarm(param1:Boolean) : void
      {
         this.pveObject.setAlarm(param1);
      }
      
      public function setTitle(param1:String) : void
      {
         this.pveObject.setTitle(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.pveObject.dispose();
         this.pveObject = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
