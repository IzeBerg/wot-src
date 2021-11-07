package net.wg.gui.battle.views.destroyTimers.utils.pairs
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.views.destroyTimers.components.notifiers.ProgressNotifier;
   import net.wg.utils.IClassFactory;
   
   public class ProgressNotifierPair extends NotifierPair
   {
       
      
      private var _normal:ProgressNotifier;
      
      private var _collapsed:ProgressNotifier;
      
      private var _progress:int;
      
      private var _max:int;
      
      private var _isActive:Boolean;
      
      public function ProgressNotifierPair(param1:String)
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         this._normal = _loc2_.getComponent(Linkages.EVENT_FILLING_IN_PROGRESS_UI,ProgressNotifier);
         this._normal.setText(param1);
         this._collapsed = _loc2_.getComponent(Linkages.SECONDARY_EVENT_FILLING_IN_PROGRESS_UI,ProgressNotifier);
         super(this._normal,this._collapsed);
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:ProgressNotifier = !!this._normal.visible ? this._normal : (!!this._collapsed.visible ? this._collapsed : null);
         if(_loc1_ != null)
         {
            _loc1_.setProgress(this._progress,this._max,this._isActive);
         }
      }
      
      override protected function onDispose() : void
      {
         this._normal = null;
         this._collapsed = null;
         super.onDispose();
      }
      
      public function setProgress(param1:int, param2:int, param3:Boolean) : void
      {
         if(this._progress == param1 && this._max == param2 && this._isActive == param3)
         {
            return;
         }
         this._progress = param1;
         this._max = param2;
         this._isActive = param3;
         this.draw();
      }
   }
}
