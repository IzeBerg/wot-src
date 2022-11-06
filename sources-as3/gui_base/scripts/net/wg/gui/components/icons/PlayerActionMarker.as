package net.wg.gui.components.icons
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class PlayerActionMarker extends UIComponentEx
   {
       
      
      private var _actionBitMask:Number = 0;
      
      private var _team:String = "common";
      
      private const ACTIONS_LABEL:String = "actions";
      
      public function PlayerActionMarker()
      {
         super();
      }
      
      public function get action() : Number
      {
         return this._actionBitMask;
      }
      
      public function set action(param1:Number) : void
      {
         if(this._actionBitMask == param1)
         {
            return;
         }
         this._actionBitMask = param1;
         invalidate();
      }
      
      public function get team() : String
      {
         return this._team;
      }
      
      public function set team(param1:String) : void
      {
         if(this._team == param1)
         {
            return;
         }
         this._team = param1;
         invalidate();
      }
      
      override protected function draw() : void
      {
         var allActions:Array = null;
         var elName:String = null;
         var i:uint = 0;
         super.draw();
         var actions:Array = PlayerActionMarkerController.instance.getActions(this._team,this._actionBitMask);
         if(actions.length)
         {
            allActions = PlayerActionMarkerController.instance.allActions;
            gotoAndStop(this.ACTIONS_LABEL);
            i = 0;
            i = 0;
            while(i < allActions.length)
            {
               elName = allActions[i];
               try
               {
                  getChildByName(elName).visible = false;
               }
               catch(err:Error)
               {
                  DebugUtils.LOG_ERROR("ERROR! PlayerActionMarker. Don\'t find Display Object by name " + elName + " for set visible false");
               }
               i++;
            }
            i = 0;
            while(i < actions.length)
            {
               elName = actions[i];
               try
               {
                  getChildByName(elName).visible = true;
               }
               catch(err:Error)
               {
                  DebugUtils.LOG_ERROR("ERROR! PlayerActionMarker. Don\'t find Display Object by name " + elName + " for set visible true");
               }
               i++;
            }
         }
         else
         {
            gotoAndStop(1);
         }
      }
   }
}
