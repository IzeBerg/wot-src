package net.wg.gui.components.controls
{
   import net.wg.utils.helpLayout.HelpLayoutVO;
   
   public class CrewOperationBtn extends IconButton
   {
       
      
      private var _helpLayoutX:Number = 0;
      
      private var _helpLayoutW:Number = 0;
      
      private var _helpLayoutId:String = "";
      
      public function CrewOperationBtn()
      {
         super();
      }
      
      override public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(!this._helpLayoutId)
         {
            this._helpLayoutId = name + "_" + Math.random();
         }
         var _loc1_:int = 1;
         var _loc2_:HelpLayoutVO = new HelpLayoutVO();
         _loc2_.x = this._helpLayoutX;
         _loc2_.y = 0;
         _loc2_.width = this._helpLayoutW;
         _loc2_.height = height + _loc1_;
         _loc2_.extensibilityDirection = _helpDirection;
         _loc2_.message = _helpText;
         _loc2_.id = this._helpLayoutId;
         _loc2_.scope = this;
         return new <HelpLayoutVO>[_loc2_];
      }
      
      public function showHelpLayoutEx(param1:Number, param2:Number) : void
      {
         this._helpLayoutX = param1;
         this._helpLayoutW = param2;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(!param1)
         {
            App.utils.counterManager.removeCounter(this);
         }
         super.visible = param1;
      }
   }
}
