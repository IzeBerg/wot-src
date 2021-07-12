package net.wg.gui.lobby.epicBattles.components.skillView
{
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class EpicBattlesUnspentPoints extends UIComponentEx
   {
      
      private static const LABEL_TO_POINTS_GAP:int = 10;
      
      private static const POINTS_TO_ICON_GAP:int = 23;
       
      
      public var pointsLabelTF:TextField = null;
      
      public var pointsTF:TextField = null;
      
      public var pointIcon:MovieClip = null;
      
      private var _pointsLabelFilters:Array;
      
      private var _showPoints:Boolean = true;
      
      private var _isInitialized:Boolean = false;
      
      public function EpicBattlesUnspentPoints()
      {
         this._pointsLabelFilters = [new DropShadowFilter(0,0,16711680,1,16,16,2,3)];
         super();
      }
      
      override protected function onDispose() : void
      {
         this._pointsLabelFilters.splice(0,this._pointsLabelFilters.length);
         this._pointsLabelFilters = null;
         this.pointIcon = null;
         this.pointsTF = null;
         this.pointsLabelTF = null;
         super.onDispose();
      }
      
      public function updateData(param1:String, param2:Boolean, param3:int) : void
      {
         if(!this._isInitialized || param2 != this._showPoints)
         {
            this._isInitialized = true;
            this._showPoints = param2;
         }
         this.pointsLabelTF.htmlText = param1;
         App.utils.commons.updateTextFieldSize(this.pointsLabelTF,true,false);
         this.pointIcon.visible = param2;
         this.pointsTF.visible = param2;
         this.pointsLabelTF.x = 0;
         if(this._showPoints)
         {
            this.pointsLabelTF.filters = null;
            this.pointsTF.text = param3.toString();
            App.utils.commons.updateTextFieldSize(this.pointsTF,true,false);
            this.pointsTF.x = this.pointsLabelTF.width + LABEL_TO_POINTS_GAP;
            this.pointIcon.x = this.pointsTF.x + this.pointsTF.width + POINTS_TO_ICON_GAP;
         }
         else
         {
            this.pointsLabelTF.filters = this._pointsLabelFilters;
         }
      }
      
      override public function get width() : Number
      {
         return !!this._showPoints ? Number(super.actualWidth) : Number(this.pointsLabelTF.width);
      }
   }
}
